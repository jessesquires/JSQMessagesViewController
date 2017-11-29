iosNode = 'jenkins-slave-mac'

//MAIN BLOCK BEGIN

if ("${env.BRANCH_NAME}" ==~ /PR-\d*/) {
  echo "Performing stages for pull request branch ${env.BRANCH_NAME}"
  runOnNode {
    fullCleanAndSetup()
    stage('Lint pod') {
      cmd_bundle_exec "fastlane lint"
    }
  }
} else if ("${env.BRANCH_NAME}" ==~ /master/) {
  echo "Performing stages after merge to branch ${env.BRANCH_NAME}"
  runOnNode {
    fullCleanAndSetup()
    stage('Publish pod') {
      cmd_bundle_exec "fastlane publish"
    }
  }
}

//MAIN BLOCK END

// Actions

def fullCleanAndSetup() {
  stage('Checkout & Setup') {
    deleteDir()
    checkout scm
    cmd 'git submodule update --init'
    echo "My branch is: ${env.BRANCH_NAME}"
    echo "Install dependences"
    cmd 'export'
    cmd '/usr/local/bin/bundle install --path vendor/bundle'
  }
}

// Helpers

def runOnNode(Closure c) {
  try {
    node(iosNode) {
      c()
    }
  } catch (InterruptedException x) {
    currentBuild.result = 'ABORTED'
  } catch (e) {
    currentBuild.result = 'FAILURE'
    handleException();
    throw e
  }
}

def handleException() {
  // TODO
}

// Shell

def cmd(String shellCommand) {
    wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm']) {
        sh shellCommand
    }
}

def cmd_bundle_exec(String bundlerCommand) {
  cmd "/usr/local/bin/bundle exec ${bundlerCommand}"
}
