const { readFileSync } = require('fs');
const yaml = require('js-yaml');

module.exports = function (source) {
  this.cacheable && this.cacheable();

  const yamlFile = (file) => {
    return readFileSync(file, 'utf-8').toString();
  }

  const yml2js = yaml.safeLoad(
    yamlFile(this.resourcePath));  

  return `module.exports = ` + JSON.stringify({
    json: yml2js});  
}