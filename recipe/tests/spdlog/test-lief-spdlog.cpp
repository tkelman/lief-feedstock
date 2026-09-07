#include <iostream>
#include <memory>
#include <utility>

#include <LIEF/logging.hpp>
#include <spdlog/spdlog.h>
#include <spdlog/sinks/null_sink.h>

int main() {
  // Construct an unregistered logger so the test exercises the public
  // shared_ptr ABI without relying on spdlog's process-global registry.
  std::cerr << "constructing external logger" << std::endl;
  auto sink = std::make_shared<spdlog::sinks::null_sink_mt>();
  std::shared_ptr<spdlog::logger> logger =
      std::make_shared<spdlog::logger>("lief-consumer-test", std::move(sink));

  std::cerr << "installing external logger" << std::endl;
  LIEF::logging::set_logger(std::move(logger));
  LIEF::logging::set_level(LIEF::logging::LEVEL::INFO);
  LIEF::logging::info("external {} consumer test", "spdlog");

  std::cerr << "resetting LIEF logger" << std::endl;
  LIEF::logging::reset();
  std::cerr << "external logger test passed" << std::endl;
  return 0;
}
