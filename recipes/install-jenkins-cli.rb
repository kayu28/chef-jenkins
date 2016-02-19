#
# Cookbook Name:: jenkins
# Recipe:: install-jenkins-cli
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

jenkins_url = "http://localhost:" + node['jenkins']['http_port'] + "/jenkins/"

script "install-jenkins-cli" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    sleep 5
    http_response_code=503
    while [ $http_response_code -ne 200 ]
    do
      http_response_code=`curl -LI #{jenkins_url}jnlpJars/jenkins-cli.jar -o /dev/null -w '%{http_code}' -s`
      echo $http_response_code
      sleep 5
    done
    wget -t 5 --waitretry 5 -O /tmp/jenkins-cli.jar #{jenkins_url}jnlpJars/jenkins-cli.jar
  EOH
end
