package com.idqqtec.nms.web.interceptor;

import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 登录拦截器
 * User: james.xu
 * Date: 2018/2/23
 * Time: 15:32
 * Version:V1.0
 */
@Controller
public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        boolean flag = true;
        //从session中获取用户信息
        Object user = request.getSession().getAttribute("user");
        //判断如果没有取到用户信息,就跳转到登陆界面
        if (user == null || "".equals(user)){
            response.sendRedirect("login");
            flag = false;
        }else {
            request.getSession().setAttribute("user",user);
        }
        return flag;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
