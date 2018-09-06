/**
 * @file 针对特定路由的处理
 * @author wangyisheng@baidu.com (wangyisheng)
 */

const got = require('got')

module.exports = {
  /**
   * 路由方法，可选值 'get', 'post', 'put', 'del', 'all'
   * 默认 'get'
   *
   * @type {string}
   */
  method: 'get',

  /**
   * 路由规则，内部使用 path-to-regexp 进行匹配
   * 例如 '/weather/:city'。
   * 必填，无默认值。
   *
   * @type {string}
   */
  pattern: '/weather/:city',

  async handler (ctx, render) {
    // 当访问 URL 是 '/weather/shanghai?type=text' 时
    // `ctx.params` 等于 `{city: 'shanghai'}`
    // `ctx.query` 等于 `{type: 'text'}`
    console.log('ctx.params =', ctx.params)
    console.log('ctx.query =', ctx.query)

    // 发送请求获取远程数据
    let {body} = await got('https://query.yahooapis.com/v1/public/yql?q=' +
      encodeURIComponent('select item.condition from weather.forecast where woeid = 2151849 and u="c"') +
      '&format=json', {json: true})
    let weatherInfo = body.query.results.channel.item.condition

    // 使用 ctx.body = render(templatePath, data) 设置响应
    // 其中 templatePath 相对于根目录，因此应该是 templates/weather.tpl 而不是 ../templates/weather.tpl
    // 为了简便，可以省略 templates/ 和后缀名(.tpl)，所以最终简写为 weather
    ctx.body = render('weather', {
      date: weatherInfo.date,
      temp: weatherInfo.temp,
      text: weatherInfo.text
    })
  }
}
