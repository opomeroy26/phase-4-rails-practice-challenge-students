class StudentsController < ApplicationController

    def index 
        students = Student.all 
        render json: students, status: :ok
    rescue ActiveRecord::RecordNotFound => invalid 
        render json: {errors: invalid.record.errors.full_messages}, status: :not_found
    end

    def create
        student = Student.find(params[:id])
        student.create!(student_params)
        render json: student, status: :ok 
    rescue ActiveRecord::RecordInvalid => invalid 
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity
        
    end

    def update 
        student = Student.find(params[:id])
        student.update!(student_params)
        render json: student, status: :ok 
    rescue ActiveRecord::RecordInvlaid => invalid 
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity

    end

    def destroy 
        student = Student.find(params[:id])
        student.destroy
        render json: student, status: :ok
    rescue ActiveRecord::RecordInvalid => invalid 
            render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    end

    private 

    def student_params 
        params.permit(:name, :major, :age)
    end
end
