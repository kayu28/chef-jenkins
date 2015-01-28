#
# Cookbook Name:: jenkins
# Recipe:: update-jenkins-updatecenter
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

directory "/var/lib/jenkins/updates" do
  owner "jenkins"
  group "jenkins"
  mode "0755"
  action :create
end

script "update-jenkins-updatecenter" do
  interpreter "bash"
  user "jenkins"
  cwd "/tmp"
  code <<-EOH
    curl -L http://updates.jenkins-ci.org/update-center.json | sed '1d;$d' > /var/lib/jenkins/updates/default.json
  EOH
  not_if "test -e /var/lib/jenkins/updates/default.json"
end

