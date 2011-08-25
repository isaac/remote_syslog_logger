
require 'remote_syslog_logger/udp_sender'
require 'logger'
require 'uri'

module RemoteSyslogLogger
  VERSION = '1.0.3'

  def self.new(remote_hostname)
    url = URI.parse remote_hostname
    logger = Logger.new(RemoteSyslogLogger::UdpSender.new(url.host, url.port, :program => url.path[1..-1]))
    logger.level = Logger.const_get(([ENV["LOG_LEVEL"].to_s.upcase, "INFO"] & %w[DEBUG INFO WARN ERROR FATAL UNKNOWN]).compact.first)
    logger
  end
end