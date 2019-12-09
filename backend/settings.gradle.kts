rootProject.name = "backend"

pluginManagement {
  repositories {
    gradlePluginPortal()
    jcenter()
    maven { url = uri("https://dl.bintray.com/gradle/gradle-plugins") }
  }
  resolutionStrategy {
    eachPlugin {
      if (requested.id.id.startsWith("org.jetbrains.kotlin")) {
        gradle.rootProject.extra["kotlinVersion"]?.let { useVersion(it as String) }
      } else if (requested.id.id == "org.springframework.boot") {
        gradle.rootProject.extra["springBootVersion"]?.let { useVersion(it as String) }
      }
    }
  }
}
