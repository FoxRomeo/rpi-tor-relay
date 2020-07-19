pipeline {
        agent {
                label 'arm32v6 && Docker'
        }
	parameters {
		string(name: 'OVERRIDE', defaultValue: '0.4.3.5', description: 'Version to use (leave "latest" to use latest release)', trim: true)
	}
        triggers {
                cron('H H(4-16) * * 4')
        }
        options {
                skipStagesAfterUnstable()
                disableResume()
                timestamps()
        }
        environment {
                DEBUG = "true"
                REGISTRY = "intrepidde"
                EMAIL_TO = 'olli.jenkins.prometheus@intrepid.de'
                NAME = "rpi-tor-relay"
                SECONDARYREGISTRY = "nexus.intrepid.local:4000"
                SECONDARYNAME = "${NAME}"
                SOFTWAREVERSION = """${sh(
                        returnStdout: true,
                        script: '/bin/bash ./get_version.sh'
                        ).trim()}"""
                SOFTWARESTRING = "<<TORVERSION>>"
                TARGETVERSION = "${SOFTWAREVERSION}"
                TAGSUFFIX = "-root"
                NOLATEST = "false"
        }
        stages {
                stage('Build') {
			environment {
			    ACTION = "build"
			}
                        steps {
                                sh '/bin/bash ./action.sh'
                        }
                }
                stage('Push') {
			environment {
			    ACTION = "push"
			}
                        steps {
                                sh '/bin/bash ./action.sh'
                        }
                }
        }
        post {
                always {
                        cleanWs()
                }
                success {
                        echo 'BUILD OK'
                }
                failure {
                        emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n -------------------------------------------------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}',
                        to: EMAIL_TO,
                        subject: 'Build failed in Jenkins: $PROJECT_NAME - #$BUILD_NUMBER'
                }
                unstable {
                        emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n -------------------------------------------------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}',
                        to: EMAIL_TO,
                        subject: 'Unstable build in Jenkins: $PROJECT_NAME - #$BUILD_NUMBER'
                }
                changed {
                        emailext body: 'Check console output at $BUILD_URL to view the results.',
                        to: EMAIL_TO,
                        subject: 'Jenkins build is back to normal: $PROJECT_NAME - #$BUILD_NUMBER'
                }
        }
}
