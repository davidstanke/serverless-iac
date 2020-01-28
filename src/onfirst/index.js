/**
 * Responds to any HTTP request.
 *
 * @param {!express:Request} req HTTP request context.
 * @param {!express:Response} res HTTP response context.
 */
exports.onFirst = (req, res) => {
  let player = req.query.player || req.body.player || 'Who';
  res.status(200).send(player);
};
