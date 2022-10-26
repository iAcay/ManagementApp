class ArtifactsController < ApplicationController

  def index
    @artifacts = Artifact.all
    @project = ActsAsTenant.current_tenant.projects.first
  end

  def show
    render show:, locals: { artifact: artifact }
  end

  def new
    artifact = Artifact.new
    artifact.project_id = params[:project_id]
    render :new, locals: { artifact: artifact }
  end

  def edit
    render :edit, locals: { artifact: artifact }
  end

  def create
    artifact = Artifact.new(artifact_params)

    respond_to do |format|
      if artifact.save
        format.html { redirect_to projects_path, notice: "Artifact was successfully created." }
        format.json { render :show, status: :created, location: artifact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: artifact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if artifact.update(artifact_params)
        format.html { redirect_to artifact_url(artifact), notice: "Artifact was successfully updated." }
        format.json { render :show, status: :ok, location: artifact }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: artifact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    artifact.destroy

    respond_to do |format|
      format.html { redirect_to projects_path, notice: "Artifact was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def artifact
      @artifact ||= Artifact.find(params[:id])
    end

    def artifact_params
      params.require(:artifact).permit(:name, :project_id, :upload)
    end
end
