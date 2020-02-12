const assert = require('assert');
const sinon = require('sinon');

const {onsecond} = require('..');

it('should return a name', () => {
  // Mock ExpressJS 'req' and 'res' parameters
  const req = {};
  const res = {send: sinon.stub()};

  // Call tested function
  onsecond(req, res);

  // Verify behavior of tested function
  assert.ok(res.send.calledOnce);
  assert.deepStrictEqual(res.send.firstCall.args, [`What`]);
});