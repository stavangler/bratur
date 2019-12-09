import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import org.jlleitschuh.gradle.ktlint.reporter.ReporterType

plugins {
  id("io.gitlab.arturbosch.detekt") version "1.2.2"
  id("org.jlleitschuh.gradle.ktlint") version "9.1.1"
  id("org.jlleitschuh.gradle.ktlint-idea") version "9.1.1"
  idea
  id("org.springframework.boot")
  id("io.spring.dependency-management") version "1.0.8.RELEASE"
  kotlin("jvm")
  kotlin("plugin.spring") version "1.3.61"
}

group = "net.stavangler.bratur"
version = "0.0.1-SNAPSHOT"
java.sourceCompatibility = JavaVersion.VERSION_1_8

repositories {
  mavenCentral()
  jcenter()
  maven { url = uri("https://dl.bintray.com/kotlin/exposed") }
}

dependencies {
  implementation("org.springframework.boot:spring-boot-starter-actuator")
  implementation("org.springframework.boot:spring-boot-starter-jdbc")
  implementation("org.springframework.boot:spring-boot-starter-rsocket")
  implementation("org.springframework.boot:spring-boot-starter-webflux")
  implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
  implementation("org.jetbrains.kotlin:kotlin-reflect")
  implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
  implementation("org.jetbrains.kotlinx:kotlinx-coroutines-reactor")
  implementation("org.springframework.kafka:spring-kafka")

  val exposedVersion = "0.17.+"
  implementation("org.jetbrains.exposed:exposed:$exposedVersion")
  implementation("org.jetbrains.exposed:spring-transaction:$exposedVersion")

  // logging
  implementation("net.logstash.logback:logstash-logback-encoder:6.+")
  implementation("io.github.microutils:kotlin-logging:1.7.+")

  implementation("org.postgresql:postgresql:42.2.+")

  // test
  testImplementation("org.springframework.boot:spring-boot-starter-test") {
    exclude(group = "org.junit.vintage", module = "junit-vintage-engine")
  }
  testImplementation("io.projectreactor:reactor-test")
  testImplementation("org.springframework.kafka:spring-kafka-test")
  testImplementation("org.jetbrains.kotlin:kotlin-test")
  testImplementation("org.jetbrains.kotlin:kotlin-test-junit")
  testImplementation("org.amshove.kluent:kluent:1.58")
  testImplementation("io.mockk:mockk:1.9")
}

tasks {
  withType<KotlinCompile> {
    kotlinOptions {
      freeCompilerArgs = listOf("-Xjsr305=strict")
      jvmTarget = "1.8"
    }
  }
  withType<Test> {
    useJUnitPlatform {
      // systemProperty("spring.datasource.url", "jdbc:postgresql://localhost:45432/kotlink")
      // systemProperty("spring.redis.url", "redis://localhost:46379")
    }
    testLogging.apply {
      events("started", "passed", "skipped", "failed")
      exceptionFormat = org.gradle.api.tasks.testing.logging.TestExceptionFormat.SHORT
      showCauses = false
      showExceptions = false
      showStackTraces = false
      showStandardStreams = false
      // remove standard output/error logging from --info builds
      // by assigning only 'failed' and 'skipped' events
      info.events = setOf(org.gradle.api.tasks.testing.logging.TestLogEvent.FAILED, org.gradle.api.tasks.testing.logging.TestLogEvent.SKIPPED)
    }
    // listen to events in the test execution lifecycle
    // see: https://nwillc.wordpress.com/2019/01/08/gradle-kotlin-dsl-closures/
    // beforeTest(
    //   closureOf<TestDescriptor> {
    //     logger.lifecycle("\t===== START TEST: ${this.className}.${this.name}")
    //   }
    // )
    afterSuite(
      KotlinClosure2<TestDescriptor, TestResult, Unit>({ descriptor, result ->
        if (descriptor.parent == null) {
          logger.lifecycle("Tests run: ${result.testCount}, Failures: ${result.failedTestCount}, Skipped: ${result.skippedTestCount}")
        }
        Unit
      })
    )
  }
}

idea {
  module {
    isDownloadJavadoc = true
    isDownloadSources = true
  }
}

detekt {
  config.setFrom(files("src/main/resources/default-detekt-config.yml"))
}

ktlint {
  version.set("0.34.2")
  outputToConsole.set(true)
  coloredOutput.set(true)
  reporters {
    reporter(ReporterType.PLAIN)
    reporter(ReporterType.CHECKSTYLE)
  }
}
