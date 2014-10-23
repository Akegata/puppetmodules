# primary_nic.rb

Facter.add("primary_nic") do
  setcode do
    Facter::Util::Resolution.exec("ip route show | awk '/default/ {print $5}'")
  end
end
