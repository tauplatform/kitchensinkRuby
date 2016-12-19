require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class ApplicationController < Rho::RhoController
  include BrowserHelper

  @resultStatus = 'success'

  def index
    render
  end

  def success?
    return @resultStatus == 'success'
  end

  def error?
    return @resultStatus == 'error'
  end

  def setDatabaseFilePath()
    render
  end

  def quit_app
    Rho::Application.quit
  end

  def minimize_app
    Rho::Application.minimize
    render :action => :confirm_minimize_app
  end

  def restore_app
    Rho::Application.minimize
    sleep(2)
    Rho::Application.restore
    render :action => :confirm_restore_app
  end


end


