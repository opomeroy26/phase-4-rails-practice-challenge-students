class InstructorsController < ApplicationController

    def index 
        instructors = Instructor.all 
        render json: instructors, status: :ok 
    rescue ActiveRecord::RecordNotFound => invalid 
        render json: {errors: invalid.record.errors.full_messages}, status: :not_found
    end

    def create 
        instructor = Instructor.find(params[:id])
        instructor.create!(instructor_params)
        render json: instructor, status: :ok
    rescue ActiveRecord::RecordInvalid => invalid 
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity

    end

    def update 
        instructor = Instructor.find(params[:id])
        instructor.update!(instructor_params)
        render json: instructor, status: :ok
    rescue ActiveRecord::RecordInvalid => invalid 
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def destroy 
        instructor = Instructor.find(params[:id])
        instructor.destroy
    rescue ActiveRecord::RecordInvalid => invalid 
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
    
    private 


    def instructor_params 
        params.permit(:name)
    end
end
