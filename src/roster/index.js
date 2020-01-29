const request = require('request')
const environment_prefix = ''
const service_domain = 'doingdevops.com'

exports.roster = (req, res) => {
  const onFirstService = 'https://' + environment_prefix + 'onfirst.' + service_domain
  const onSecondService = 'https://' + environment_prefix + 'onsecond.' + service_domain

  const onfirst = new Promise(function(resolve, reject) {
    request({url:onFirstService}, (error,response) => {
      resolve(response.body)
    })
  })

  const onsecond = new Promise(function(resolve, reject) {
    request({url:onSecondService}, (error,response) => {
      resolve(response.body)
    })
  })

  Promise.all([onfirst, onsecond]).then(function(values) {
    res.send("<h1>" + values[0] + " is on first. " + values[1] + " is on second." + "</h1>")
  })
}