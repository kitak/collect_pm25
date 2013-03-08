# coding: utf-8
require 'ishikawa_air_pollution'
require 'date'
require 'logger'
require 'my_drip'

logger = Logger.new('/home/kitak/collect_pm25/debug.log')
logger.debug __FILE__

begin
  MyDrip.invoke
  client = IshikawaAirPollution.new
  pm25_data = client.pm25
  fetch_time = client.observation["start"]
  pm25_data.merge!({
    fetch_time: fetch_time 
  })
  MyDrip.write(pm25_data, 'collect_pm25',
      	                  "collect_pm25_date=#{fetch_time.strftime('%Y-%m-%d')}",
  	                  "collect_pm25_datetime=#{fetch_time.strftime('%Y-%m-%d %H:%M')}",
  	                  "collect_pm25_year=#{fetch_time.strftime('%Y')}",
  	                  "collect_pm25_month=#{fetch_time.strftime('%m')}",
  	                  "collect_pm25_hour=#{fetch_time.strftime('%H')}")
  logger.debug "insert pm25 data"
rescue => e
  logger.debug e
  retry
end
