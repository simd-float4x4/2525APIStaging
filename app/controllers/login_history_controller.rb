class LoginHistoryController < ApplicationController
    def index
        @history = History.all.order(created_at: "DESC")
        render layout: "layouts/application"
    end
end