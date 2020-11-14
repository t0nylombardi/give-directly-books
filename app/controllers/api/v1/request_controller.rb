# frozen_string_literal: true
module Api
  module V1
    class RequestController < ApplicationController
      before_action :set_books, only: [:show, :destroy]
      before_action :validate_email, only: [:request_id]
      
      # # full list of all books in the system
      #
      # @return [JSON] 
      #
      def index
        @books = Book.all
        
        render json: @books
      end

      
      # Shows single Book record
      #
      # @return [JSON] 
      #
      def show
        render json: @book
      end

      # Requests a book tile to take out.
      #
      # @return [JSON]
      #
      def request_title
        payload = {
          status: 400, 
          message: "invailed email"
        }
        render json: payload, status: :bad_request unless validate_email

        book = Book.find_by_title(params[:title])
        return unless book 

        if book.timestamp.empty? 
          book.update_attribute(:timestamp, DateTime.now)
          render json: {
            id: book.id,
            avilable: book.available,
            title: book.title,
            timestamp: book.timestamp.to_time.iso8601
          }
        end
        
      end

      # Deletes the request for that requested book.
      # NOTE: the request asked for an empty body and I feel like that is 
      # a bad user expeirence.
      #
      # @return [JSON]
      #
      def destroy
        @book.timestamp = ""
         
        render json: {
          status: 200, 
          message: "Your request for book #{@book.title} has been removed"
        }
      end

      private 
      
      # Use callbacks to share common setup or constraints between actions. 
      #
      # @return [ActiveRecord Object]
      #
      def set_books
        result = Book.where(id: params[:id]).first
        if result.nil?
          @book = Book.all
        else
          @book = result
        end
      end

      
      # Validates email formate
      #   This regex could be simplified or beafed up. figured a middle
      #   ground would work for now.
      #
      # @return [<Type>] <description>
      #
      def validate_email
        params[:email] =~ /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/ 
      end
    end

  end
  
end