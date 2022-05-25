def CREDS = [
    string(credentialsId: 'github-api-token',
           variable: 'GITHUB_TOKEN'),
    aws(credentialsId: 'aws',
        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'),
]

pipeline {
    agent {
        node {
            label 'ec2-fleet'
            customWorkspace("/tmp/workspace/${env.BUILD_TAG}")
        }
    }

    options {
        timeout time: 1, unit: 'HOURS'
        timestamps()
        ansiColor 'xterm'
        withCredentials(CREDS)
    }

    stages {
        stage('Lint') {
            steps {
                sh 'make -j4 lint'
            }
        }

        stage('Test') {
            steps {
                sh 'make -j4 test'
            }
        }

        stage('Build') {
            steps {
                sh 'make build'
                archiveArtifacts allowEmptyArchive: true, artifacts: 'tmp/version-info', caseSensitive: false, followSymlinks: false
            }
        }

        stage('Publish') {
            when {
                anyOf {
                    branch "master"
                    branch "main"
                }
            }
            steps {
                sh 'make publish'
                archiveArtifacts allowEmptyArchive: true, artifacts: 'output/**/*.yaml', caseSensitive: false, followSymlinks: false
            }
        }
    }

    post {
        always {
            jiraSendBuildInfo site: 'logdna.atlassian.net'
        }
    }
}
