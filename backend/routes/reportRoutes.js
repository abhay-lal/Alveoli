const express = require('express');
const reportController = require('../controllers/reportController');
const authController = require('../controllers/authController');

const router = express.Router({ mergeParams: true });

router.use(authController.protect);

router
  .route('/')
  .get(reportController.getAllReports)
  .post(
    authController.restrictTo('user'),
    reportController.setUserIds,
    reportController.createReport
  );

router
  .route('/:id')
  .get(reportController.getReport)
  .patch(
    authController.restrictTo('user', 'admin'),
    reportController.updateReport
  )
  .delete(
    authController.restrictTo('user', 'admin'),
    reportController.deleteReport
  );

module.exports = router;
