<<<<<<< HEAD
node('node') {
=======
#!/usr/bin/env groovy

import hudson.model.*
import hudson.EnvVars
import groovy.json.JsonSlurperClassic
import groovy.json.JsonBuilder
import groovy.json.JsonOutput
import java.net.URL

node('master') {
    def app

>>>>>>> ce484b8173592173a5d3737399488463413373ca
    currentBuild.result = "SUCCESS"
    try {
       stage('Checkout'){
            checkout([$class: 'GitSCM',
				branches: [[name: '*/master']],
                doGenerateSubmoduleConfigurations: false,
                extensions: [[$class: 'SubmoduleOption',
					disableSubmodules: false,
					parentCredentials: true,
					recursiveSubmodules: true,
					trackingSubmodules: false]], 
				submoduleCfg: [], 
<<<<<<< HEAD
				userRemoteConfigs: [[credentialsId: 'jenkins', url: 'https://github.com/njoyard/focal.git']]])
       }

       stage('Test'){

         env.NODE_ENV = "test"

         print "Environment will be : ${env.NODE_ENV}"

         sh 'node -v'
         sh 'npm prune'
         sh 'npm install'
         sh 'npm test'

       }

       stage('Build Docker'){

            sh './dockerBuild.sh'
       }

       stage('Deploy'){

         echo 'Push to Repo'
         sh './dockerPushToRepo.sh'

         echo 'ssh to web server and tell it to pull new image'
         sh 'ssh deploy@xxxxx.xxxxx.com running/xxxxxxx/dockerRun.sh'

       }

       stage('Cleanup'){

         echo 'prune and cleanup'
         sh 'npm prune'
         sh 'rm node_modules -rf'

=======
				userRemoteConfigs: [[url: 'https://github.com/cologne-js/cologne-js.git']]])
       }
       stage('Build'){
            env.NODE_ENV = "test"
            print "Environment will be : ${env.NODE_ENV}"
            sh 'node -v'
            sh 'npm install'
            sh 'nohup node app.js &'            
            def res = sh(returnStdout:true, script: 'ps -axuwwww | grep node | grep app | grep -iv slack').trim()
            println res
            String[] sp = res.split(" +")
            println("second word is " + sp[1])
       }
       stage('Test'){
            def testresult = sh(returnStdout: true, script: 'curl localhost:3000').trim()
            test = testresult.take(1000)
            
            def findCool = (test =~ /Cologne/)
            println test
            println findCool
       }
       stage('Build Image'){
            if(currentBuild.result == null || currentBuild.result == 'SUCCESS' || findCool[0]){
                app = docker.build("dimakievua/solidtest")
            }
       }
       stage('Cleanup'){
         echo 'prune and cleanup'
         sh 'npm prune'
         sh 'rm node_modules -rf'
>>>>>>> ce484b8173592173a5d3737399488463413373ca
         mail body: 'project build successful',
                     from: 'xxxx@yyyyy.com',
                     replyTo: 'xxxx@yyyy.com',
                     subject: 'project build successful',
                     to: 'yyyyy@yyyy.com'
       }
<<<<<<< HEAD



    }
    catch (err) {

        currentBuild.result = "FAILURE"

            mail body: "project build error is here: ${env.BUILD_URL}" ,
            from: 'xxxx@yyyy.com',
            replyTo: 'yyyy@yyyy.com',
            subject: 'project build failed',
            to: 'zzzz@yyyyy.com'

        throw err
    }

=======
    }
    catch (err) {
        currentBuild.result = "FAILURE"
        echo "Job failed."
        throw err
    }
>>>>>>> ce484b8173592173a5d3737399488463413373ca
}
