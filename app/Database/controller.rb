require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class DatabaseController < Rho::RhoController
  include BrowserHelper

  def index
    @title = 'Config'
    render
  end

  def success?
    return @resultStatus == 'success'
  end

  def error?
    return @resultStatus == 'error'
  end

  def be_success
    @resultStatus = 'success';
  end

  def be_error
    @resultStatus = 'error';
  end

  def result_css_class
    temp = @result.nil? ? 'hidden' : ''
    return temp if @result.nil?
    if success?
      temp = temp + ' alert-success'
    end

    if error?
      temp = temp + ' alert-danger'
    end
    return temp
  end

  def common_example
    render action: :common_example
  end

  def do_action
    begin
      if @params['createTable']
        do_create_table(@params['tableName'])
      end
      if @params['showTables']
        do_show_tables
      end
      if @params['destroyTable']
        do_destroy_table(@params['tableName'])
      end
      be_success
    rescue Exception => e
      @result = e.message
      be_error
    end
    render action: :common_example
  end


  def do_create_table(tableName)
    db = Rho::Database.new(Rho::Application.databaseFilePath('test'), 'test')
    db.executeSql("create table " + tableName + "(a, b);")
    db.close()
    @result = "Table has been created"
  end

  def do_show_tables
    db = Rho::Database.new(Rho::Application.databaseFilePath('test'), 'test')
    value = db.executeSql("SELECT name FROM sqlite_master WHERE type='table'")
    db.close
    @result = value
  end

  def do_destroy_table(tableName)
    db = Rho::Database.new(Rho::Application.databaseFilePath('test'), 'test')
    db.destroyTable(tableName)
    db.close()
    @result = "Table was destroyed"
  end


end


