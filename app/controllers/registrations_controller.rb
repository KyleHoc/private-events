class RegistrationsController < ApplicationController
    private

    def registration_params
      params.require(:registration).permit(:event_id)
    end
  end