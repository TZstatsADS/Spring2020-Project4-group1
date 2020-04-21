#Define a function to calculate RMSE
RMSE <- function(rating, est_rating){
  sqr_err <- function(obs){
    sqr_error <- (obs[3] - est_rating[as.character(obs[2]), as.character(obs[1])])^2
    return(sqr_error)
  }
  return(sqrt(mean(apply(rating, 1, sqr_err))))  
}

#Stochastic Gradient Descent
# a function returns a list containing factorized matrices p and q, training and testing RMSEs.
gradesc.r13 <- function(f = 10, 
                    lambda = 0.3,lrate = 0.01, max.iter, stopping.deriv = 0.01,
                    data, train, test){
  set.seed(0)
  #random assign value to matrix p and q
  p <- round(matrix(runif(f*U, -1, 1), ncol = U),3 )
  colnames(p) <- as.character(1:U)
  q <- round(matrix(runif(f*I, -1, 1), ncol = I),3)
  colnames(q) <- levels(as.factor(data$movieId))
  alpha <- round(runif(U, -1, 1),3)
  names(alpha) <- as.character(1:U)
  
  train_RMSE <- c()
  test_RMSE <- c()
  
  for(l in 1:max.iter){
    cat( "ITERATION: ", l, "\n")
    sample_idx <- sample(1:nrow(train), nrow(train))
    #loop through each training case and perform update
    for (s in sample_idx){
      #print(s)
      u <- as.character(train[s,1])
      
      i <- as.character(train[s,2])
      
      mu <- mean(train$rating)
      b_i <- mean(train[train$movieId == i,]$rating)-mu
      b_u <- mean(train[train$userId == u,]$rating)-mu
      dev_u_t <- train[s,6]*(train[s,7]^lrate)
      r_ui <- train[s,3]
      r_hat_ui <- (t(q[,i]) %*% p[,u])+ b_i + b_u + mu + (alpha[u]*dev_u_t)
      e_ui <- r_ui - r_hat_ui 

      grad_q <- e_ui %*% p[,u] - lambda * q[,i] 
      if (all(abs(grad_q) > stopping.deriv, na.rm = T)){
        q[,i] <- q[,i] + lrate * grad_q
      }
      
      grad_p <- e_ui %*% q[,i] - lambda * p[,u]
      if (all(abs(grad_p) > stopping.deriv, na.rm = T)){
        p[,u] <- p[,u] + lrate * grad_p
      }
      
      grad_alpha <- e_ui %*% dev_u_t - lambda * alpha[u]
      if (all(abs(grad_alpha) > stopping.deriv, na.rm = T)){
        alpha[u] <- alpha[u] + lrate * grad_alpha
      }
      
    }
    
    #print the values of training and testing RMSE
    if (l %% 10 == 0){
      cat("epoch:", l, "\t")
      est_rating <- t(q) %*% p
      rownames(est_rating) <- levels(as.factor(data$movieId))
      
      train_RMSE_cur <- RMSE(train, est_rating)
      cat("training RMSE:", train_RMSE_cur, "\t")
      train_RMSE <- c(train_RMSE, train_RMSE_cur)
      
      test_RMSE_cur <- RMSE(test, est_rating)
      cat("test RMSE:",test_RMSE_cur, "\n")
      test_RMSE <- c(test_RMSE, test_RMSE_cur)
    }
  }

  return(list(p = p, q = q, alpha = alpha, train_RMSE = train_RMSE, test_RMSE = test_RMSE))
}
