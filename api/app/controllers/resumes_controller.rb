class ResumesController < ApplicationController
  before_action :set_resume, only: [:show, :update, :destroy]

  def index
    resumes = Resume.all.order(created_at: :desc)

    render json: resumes
  end

  def show
    render json: @resume
  end

  def create
    resume = Resume.new(resume_params)

    if resume.save
      render json: resume, status: :created
    else
      render json: { errors: resume.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @resume.update(resume)
      render json: @resume
    else
      render json: { errors: @resume.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @resume.destroy

    head :no_content
  end

  private

  def resume_params
    params.require(:resume).permit(
      :title,
    )
  end

  private

  def set_resume
    @resume = Resume.find(params[:id])
  end
end
