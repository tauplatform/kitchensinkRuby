require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class SignatureController < Rho::RhoController
  include BrowserHelper

  def index
    render
  end

  def take_full_screen
    render action: :take_full_screen
  end


  def on_signature_taken
    puts "Signature: #{@params}"
    begin
      if (@params['status'] == 'ok')
        if Rho::System.platform === Rho::System::PLATFORM_IOS
          image_path = @params['imageUri'];
        else
          image_path = @params['imageUri'][7..-1]
        end
        Rho::WebView.executeJavascript("showResult('#{@params.to_s}')")
        Rho::WebView.executeJavascript("$('#image').attr('src', '#{image_path}')")
      end
    rescue Exception => e
      puts "showError('#{e.message}');"
      Rho::WebView.executeJavascript("showError(\"#{e.message}\");")
    end
  end

  def do_take_full_screen
    filename = Rho::RhoFile.join(Rho::Application.databaseBlobFolder, Time.new.to_i.to_s);
    Rho::Signature.takeFullScreen({fileName: filename}, url_for(:action => :on_signature_taken))
  end


end


