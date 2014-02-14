require_relative 'software_library'
require_relative 'power_shell'

class ProvisionerLocator
  def initialize
    @software_library = SoftwareLibrary.new
  end

  def install(software)
    @software_library.get_installer_for(software)
  end

  def configure(software)
    @software_library.get_configurator_for(software)
  end

  def prepare_install(platform)
    if platform == :windows
      PowerShell.run 'set-executionpolicy Unrestricted -force'
      PowerShell.run '(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex'
      PowerShell.run 'Install-Module pscx'
    end
  end

  private
  @software_library
end