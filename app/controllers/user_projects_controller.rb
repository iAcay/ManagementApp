class UserProjectsController < ApplicationController

  def create
    user = User.find(params.dig(:user_project, :user).to_i)
    project = Project.find(params.dig(:user_project, :project).to_i)
    user_project = UserProject.new(user_id: user.id, project_id: project.id)

    respond_to do |format|
      if user_project.save
        format.html { redirect_to project_path(project), notice: "User was successfully added to the project." }
        format.json { render :show, status: :created, location: user_project }
      else
        format.html { redirect_to project_path(project), alert: "Something went wrong." }
        format.json { render json: user_project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    user_project.destroy

    respond_to do |format|
      format.html { redirect_to project_path(user_project.project), notice: "User was successfully removed from the project." }
      format.json { head :no_content }
    end
  end

  private
    def user_project
      @user_project ||= UserProject.find(params[:id])
    end

    def user_project_params
      params.require(:user_project).permit(:project, :user)
    end
end
