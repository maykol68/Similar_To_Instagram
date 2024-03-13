class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Error
  include Language
  include Authorization
    
end
