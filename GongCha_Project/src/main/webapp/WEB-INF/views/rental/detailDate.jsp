<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<c:forEach var="s" items="${s_list }">
								<c:if test="${s.available == 1}">
										<li class="rental">
									<a href="/rental/order?no=${s.stadium_match_no}">
											<p class="rTime">
											${s.start_time }~<br>${s.end_time}
											</p>
									</a>
										</li>
								</c:if>
								<c:if test="${s.available == 0}">
									<li class="rental soldout">
									<a onclick="checked();">
										<p class="rTime">
											${s.start_time }~<br>${s.end_time}
										</p>
									</a>
									</li>
								</c:if>
							</c:forEach>