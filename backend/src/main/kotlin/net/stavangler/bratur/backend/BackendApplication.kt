package net.stavangler.bratur.backend

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class BackendApplication

fun main(args: Array<String>) {
  @Suppress("SpreadOperator")
  runApplication<BackendApplication>(*args)
}
