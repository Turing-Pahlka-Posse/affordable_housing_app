class HomeController < ApplicationController
  def index
    service = GoogleService.new
    @neighborhoods = service.addresses
  end
end
