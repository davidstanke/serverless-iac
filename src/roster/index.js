const request = require('request')
const pug = require('pug')

const environment_prefix = process.env.ENVIRONMENT_PREFIX || ''
const service_domain = 'doingdevops.com'

exports.roster = (req, res) => {
  const onFirstService = 'https://' + environment_prefix + 'onfirst.' + service_domain
  const onSecondService = 'https://' + environment_prefix + 'onsecond.' + service_domain

  const onfirst = new Promise(function(resolve, reject) {
    console.log("requesting " + onFirstService)
    request({url:onFirstService,timeout:10000}, (error,response) => {
      if(error) {
        resolve("UNKNOWN")
      } else {
        resolve(response.body)
      }
    })
  })

  const onsecond = new Promise(function(resolve, reject) {
    console.log("requesting " + onSecondService)
    request({url:onSecondService,timeout:10000}, (error,response) => {
      if(error) {
        resolve("UNKNOWN")
      } else {
        resolve(response.body)
      }
    })
  })

  Promise.all([onfirst, onsecond]).then(function(values) {
    res.send(pug.renderFile('templates/index.pug', {
      onfirst: values[0],
      onsecond: values[1]
    }))
    // res.send("<h1><b style=color:blue>" + values[0] + "</b>'s on first. <b style=color:blue>" + values[1] + "</b>'s on second." + "</h1>")
  })
}