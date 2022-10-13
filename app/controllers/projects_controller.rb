class ProjectsController < ApplicationController
  before_action :organization_selected?, except: %i[index]
  before_action :proper_organization_member, except: %i[index new create]
  
  def show
    project_users = UserProject.where(project_id: project.id)
    account = ActsAsTenant.current_tenant
    potential_new_members = account.users - project.users
    render :show, locals: { project: project, project_users: project_users, potential_new_members: potential_new_members }
  end

  def new
    render :new, locals: { project: Project.new }
  end

  def edit
    render :edit, locals: { project: project }
  end

  def create
    project = Project.new(project_params)
    project.users << current_user
    
    respond_to do |format|
      if project.save
        format.html { redirect_to root_url, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: project }
      else
        format.html { render :new, locals: { project: project }, status: :unprocessable_entity }
        format.json { render json: project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if project.update(project_params)
        format.html { redirect_to project_url(project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    project.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def project
      @project ||= Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :title, :details, :expected_completion_date)
    end

    def organization_selected?
      return if ActsAsTenant.current_tenant.present?

      redirect_to root_path, alert: 'Only organization members can do that.'
    end

    def proper_organization_member
      return if project.account == ActsAsTenant.current_tenant

      redirect_to root_path, alert: 'You are not allowed.'
    end
end
