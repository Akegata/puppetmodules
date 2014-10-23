# primary_ipaddress.rb

Facter.add("primary_ipaddress") do
  setcode do
    Facter::Util::Resolution.exec("ip addr show $(ip route show | awk '/default/ {print $5}') | egrep $(ip route show | awk '/default/ {print $5}')\\s?$  | awk '{ print $2 }' | awk -F\/ '{ print $1}'")
  end
end
