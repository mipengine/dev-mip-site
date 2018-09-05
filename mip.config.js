/**
 * @file mip页面项目配置项
 * @author
 */

module.exports = {
  dev: {
    /**
     * 启动mip server调试的端口号
     *
     * @type {number}
     */
    port: 8200,

    /**
     * 启用调试页面自动刷新
     *
     * @type {boolean}
     */
    livereload: true,

    /**
     * server 启动自动打开页面，false 为关闭
     * 例如 '/example/index.html'
     *
     * @type {string|boolean}
     */
    autoopen: false,

    /**
     * 忽略沙盒注入或校验，可选值为 sandbox/whitelist/sandbox,whitelist
     * 默认 sandbox
     *
     * @type {string}
     */
    ignore: 'sandbox,whitelist',

    /**
     * 静态资源 publicPath
     * 默认 ''
     *
     * @type {string}
     */
    asset: ''
  }
}
