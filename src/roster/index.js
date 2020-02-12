const request = require('request')
const pug = require('pug')

const onFirstService = process.env.SERVICE_ONFIRST || 'ENV.SERVICE_ONFIRST-is-undefined'
const onSecondService = process.env.SERVICE_ONSECOND || 'ENV.SERVICE_ONSECOND-is-undefined'
const onThirdService = process.env.SERVICE_ONTHIRD || 'ENV.SERVICE_ONTHIRD-is-undefined'

exports.roster = (req, res) => {

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

  const onthird = new Promise(function(resolve, reject) {
    console.log("requesting " + onThirdService)
    request({url:onThirdService,timeout:10000}, (error,response) => {
      if(error) {
        resolve("UNKNOWN")
      } else {
        resolve(response.body)
      }
    })
  })

  Promise.all([onfirst, onsecond, onthird]).then(function(values) {
    res.send(pug.renderFile('templates/index.pug', {
      onfirst: values[0],
      onsecond: values[1],
      onthird: values[2]
    }))
    // res.send("<h1><b style=color:blue>" + values[0] + "</b>'s on first. <b style=color:blue>" + values[1] + "</b>'s on second." + "</h1>")
  })
}