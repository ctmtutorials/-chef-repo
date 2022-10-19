title "Minecraft server check"

control "Minecraft" do # A control is like a wrapper for a set of related tests
  impact 1.0 # How critical a failure is, 1 is critical
  title "Running minecraft server" # Readable by a human
  desc "Check if the minecraft server is started successfully" # Optional description
  describe systemd_service('minecraft') do  # The actual test
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end                                              
end