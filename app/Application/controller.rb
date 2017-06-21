require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class ApplicationController < Rho::RhoController
  include BrowserHelper

  def index
    render
  end

  def success?
    return @resultStatus == 'success'
  end

  def error?
    return @resultStatus == 'error'
  end

  def be_success(aString)
    @result = aString
    @resultStatus = 'success'
  end

  def be_error(aString)
    @result = aString
    @resultStatus = 'error'
  end

  def result_css_class
    if @result.nil?
      return 'hidden'
    end
    if success?
      return 'alert-success'
    end
    if error?
      return 'alert-danger'
    end
  end

  def databaseFilePath
    render :action => :app_databaseFilePath
  end

  def do_databaseFilePath
    begin
      value = @params['value']
      be_success(Rho::Application.databaseFilePath(value))
    rescue Exception => e
      be_error(e.message)
    end
    render :action => :app_databaseFilePath
  end

  def expandDatabaseBlobFilePath
    render :action => :app_expandDatabaseBlobFilePath
  end

  def do_expandDatabaseBlobFilePath
    begin
      value = @params['value']
      be_success(Rho::Application.expandDatabaseBlobFilePath(value))
    rescue Exception => e
      be_error(e.message)
    end
    render :action => :app_expandDatabaseBlobFilePath
  end

  def minimize_and_restore()
    render :action => :app_minimize_and_restore
  end

  def do_minimize()
    begin
      Rho::Application.minimize
      sleep(2)
      Rho::Application.restore
      be_success('The application was minimized and restored')
    rescue Exception => e
      be_error(e.message)
    end
    render :action => :app_minimize_and_restore
  end

  def modelFolderPath
    render :action => :app_modelFolderPath
  end

  def do_modelFolderPath
    begin
      value = @params['value']
      be_success(Rho::Application.modelFolderPath(value))
    rescue Exception => e
      be_error(e.message)
    end
    render :action => :app_modelFolderPath
  end

  def quit
    render :action => :app_quit
  end

  def do_quit
    begin
      Rho::Application.quit()
    rescue Exception => e
      be_error(e.message)
    end
    render :action => :app_quit
  end

  def relativeDatabaseBlobFilePath
    render :action => :app_relativeDatabaseBlobFilePath
  end

  def do_relativeDatabaseBlobFilePath
    begin
      value = @params['value']
      be_success (Rho::Application.relativeDatabaseBlobFilePath(Rho::Application.databaseBlobFolder + '/' + value))
    rescue Exception => e
      be_error(e.message)
    end
    render :action => :app_relativeDatabaseBlobFilePath
  end

  def applicationNotifyCallback
    value = @params['applicationEvent']
    Rho::WebView.executeJavascript("$('.result div').append('<div>#{ Time.now.strftime('%k:%m:%S')} - #{value}</div>')")

  end

  def setApplicationNotify
    render :action => :app_setApplicationNotify
  end

  def do_setApplicationNotify
    begin
      Rho::Application.setApplicationNotify(url_for(:action => :applicationNotifyCallback))
      be_success('')
    rescue Exception => e
      be_error(e.message)
    end
    render :action => :app_setApplicationNotify
  end

end


