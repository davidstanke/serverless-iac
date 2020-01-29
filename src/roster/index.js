const request = require('request')
const environment_prefix = process.env.ENVIRONMENT_PREFIX || ''
const service_domain = 'doingdevops.com'

exports.roster = (req, res) => {
  const onFirstService = 'https://' + environment_prefix + 'onfirst.' + service_domain
  const onSecondService = 'https://' + environment_prefix + 'onsecond.' + service_domain

  const onfirst = new Promise(function(resolve, reject) {
    request({url:onFirstService,timeout:1000}, (error,response) => {
      if(error) {
        resolve("UNKNOWN")
      } else {
        resolve(response.body)
      }
    })
  })

  const onsecond = new Promise(function(resolve, reject) {
    request({url:onSecondService,timeout:1000}, (error,response) => {
      if(error) {
        resolve("UNKNOWN")
      } else {
        resolve(response.body)
      }
    })
  })

  Promise.all([onfirst, onsecond]).then(function(values) {
    res.send("<h1><b>" + values[0] + "</b> is on first. <b>" + values[1] + "</b> is on second." + "</h1>")
  })
}