# -*- coding: utf-8 -*-
class PeerReviewsController < ApplicationController
  def index
    @peer_reviews_not_replyed = session[:user].peer_reviews.not_replyed
    @peer_reviews_replyed = session[:user].peer_reviews.replyed
  end

  def show
    @peer_review = PeerReview.find(params[:id])
  end

  def reply
    @peer_review = PeerReview.find(params[:peer_review][:id])
    @peer_review.reply = params[:peer_review][:reply]
    unless @peer_review.save
      redirect_to :action => :show, :id => @peer_review.id
      return
    end
    redirect_to :action => :index
    return
  end
end
