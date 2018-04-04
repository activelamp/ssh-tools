# SSH Tools for Jenkins on K8s

Use this container in a `Jenkinsfile` to place a `.ssh/config` in the home directory of the root user

## Example

```bash
podTemplate(label: 'my-build', containers: [
  containerTemplate(name: 'ssh-tools', image: 'activelamp/ssh_tools:latest', ttyEnabled: true),
  containerTemplate(name: 'cli', image: 'docksal/cli:php7.1', ttyEnabled: true),
 ]) {

  node ('my-build') {

    // Get the credentials in place set by the ssh-tools container
    container('cli') {
      sh 'mkdir -p /root/.ssh'
      sh 'cp /home/jenkins/.ssh/config /root/.ssh/config'
    }

    checkout scm

    stage('Build') {
      container('cli') {
        withCredentials([[$class: 'SSHUserPrivateKeyBinding', credentialsId: 'tomfriedhof', keyFileVariable: 'SSH_KEY_REPO']]) {
          sh 'GIT_SSH_COMMAND=\'ssh -i $SSH_KEY_REPO\' git clone git@github.com:tomfriedhof/some-repo.git'
        }
      }
    }

    stage('Test') {
    }

    stage('Deploy') {
    }
  }

}
```