node {
  stage('========== Clone repository ==========') {
    checkout scm
  }
  stage('========== Build image ==========') {
    app = docker.build("jinjordan/front")
    app2 = docker.build("jinjordan/back")
  }
  stage('========== Push image ==========') {
    docker.withRegistry('https://registry.hub.docker.com', 'Jinkins_Docker') {
      app.push("${env.BUILD_NUMBER}")
      app.push("latest")
    }
  }
}