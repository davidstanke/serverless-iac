const request = require('request')
const environment_prefix = process.env.ENVIRONMENT_PREFIX || ''
const service_domain = 'doingdevops.com'

exports.roster = (req, res) => {
  const onFirstService = 'https://' + environment_prefix + 'onfirst.' + service_domain
  const onSecondService = 'https://' + environment_prefix + 'onsecond.' + service_domain

  const onfirst = new Promise(function(resolve, reject) {
    console.log("requesting " + onFirstService)
    request({url:onFirstService,timeout:3000}, (error,response) => {
      if(error) {
        resolve("UNKNOWN")
      } else {
        resolve(response.body)
      }
    })
  })

  const onsecond = new Promise(function(resolve, reject) {
    console.log("requesting " + onSecondService)
    request({url:onSecondService,timeout:3000}, (error,response) => {
      if(error) {
        resolve("UNKNOWN")
      } else {
        resolve(response.body)
      }
    })
  })

  Promise.all([onfirst, onsecond]).then(function(values) {
    res.send("<h1><b style=color:blue>" + values[0] + "</b> is on first. <b style=color:blue>" + values[1] + "</b> is on second." + "</h1>")
  })
}