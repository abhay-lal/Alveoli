const express = require('express');
const morgan = require('morgan');
const rateLimit = require('express-rate-limit');
const helmet = require('helmet');
const mongoSanitize = require('express-mongo-sanitize');
const xss = require('xss-clean');
const hpp = require('hpp');
const cookieParser = require('cookie-parser');
const compression = require('compression');
const cors = require('cors');

const AppError = require('./utils/appError');
const globalErrorHandler = require('./controllers/errorController');
const userRouter = require('./routes/userRoutes');
const reportRouter= require('./routes/reportRoutes')
// Start express app
const app = express();

app.enable('trust proxy');


const corsOptions ={
  origin:['https://localhost:3000','https://alveoli.netlify.app'], 
  credentials:true,
  sameSite: 'none',            //access-control-allow-credentials:true
  optionSuccessStatus:200
}

// app.use(cors());
// Access-Control-Allow-Origin *
// api.natours.com, front-end natours.com
app.use(cors(corsOptions));

app.options('*', cors());
// app.options('/api/v1/tours/:id', cors());

// Set security HTTP headers
app.use(helmet());


if (process.env.NODE_ENV === 'development') {
  app.use(morgan('dev'));
}


const limiter = rateLimit({
  max: 10000,
  windowMs: 60 * 60 * 1000,
  message: 'Too many requests from this IP, please try again in an hour!'
});
app.use('/api', limiter);



app.use(express.json({ limit: '10kb' }));
app.use(express.urlencoded({ extended: true, limit: '10kb' }));
app.use(cookieParser());


app.use(mongoSanitize());

app.use(xss());

app.use(hpp());
  // hpp({
  //   whitelist: [
      
  //   ]
  // })
// );

app.use(compression());

// Test middleware
app.use((req, res, next) => {
  req.requestTime = new Date().toISOString();
  next();
});

// 3) ROUTES
app.use('/api/users', userRouter);
app.use('/api/reports', reportRouter);

app.all('*', (req, res, next) => {
  next(new AppError(`Can't find ${req.originalUrl} on this server!`, 404));
});

app.use(globalErrorHandler);

module.exports = app;