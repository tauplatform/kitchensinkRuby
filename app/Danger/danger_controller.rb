require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class DangerController < Rho::RhoController
  include BrowserHelper

  @resultStatus = 'success'

  def index
    render
  end




end