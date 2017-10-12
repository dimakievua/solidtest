#!/usr/bin/env groovy

import hudson.model.*
import hudson.EnvVars
import groovy.json.JsonSlurperClassic
import groovy.json.JsonBuilder
import groovy.json.JsonOutput
import java.net.URL

node('master') {
    def app

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
         mail body: 'project build successful',
                     from: 'xxxx@yyyyy.com',
                     replyTo: 'xxxx@yyyy.com',
                     subject: 'project build successful',
                     to: 'yyyyy@yyyy.com'
       }
    }
    catch (err) {
        currentBuild.result = "FAILURE"
        echo "Job failed."
        throw err
    }
}
