<?php

/**
 * @file SubmissionReviewHandler.inc.php
 *
 * Copyright (c) 2000-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class SubmissionReviewHandler
 * @ingroup pages_reviewer
 *
 * @brief Handle requests for submission tracking. 
 */

//$Id$

import('pages.reviewer.ReviewerHandler');

class SubmissionReviewHandler extends ReviewerHandler {
	/** submission associated with the request **/
	var $submission;
	
	/** user associated with the request **/
	var $user;
		
	/**
	 * Constructor
	 **/
	function SubmissionReviewHandler() {
		parent::ReviewerHandler();
	}

	function submission($args) {
		$reviewId = $args[0];

		$this->validate($reviewId);
		$reviewerSubmission =& $this->submission;
		$user =& $this->user;
		$conference =& Request::getConference();
                $schedConf =& Request::getSchedConf();
		
		$reviewAssignmentDao =& DAORegistry::getDAO('ReviewAssignmentDAO');
		$reviewAssignment = $reviewAssignmentDao->getReviewAssignmentById($reviewId);
		
		$reviewFormResponseDao =& DAORegistry::getDAO('ReviewFormResponseDAO');

		if ($reviewAssignment->getDateConfirmed() == null) {
			$confirmedStatus = 0;
		} else {
			$confirmedStatus = 1;
		}

		$this->setupTemplate(true, $reviewerSubmission->getPaperId(), $reviewId);

		$templateMgr =& TemplateManager::getManager();

		$templateMgr->assign_by_ref('user', $user);
		$templateMgr->assign_by_ref('submission', $reviewerSubmission);
		$templateMgr->assign_by_ref('reviewAssignment', $reviewAssignment);
		$templateMgr->assign('confirmedStatus', $confirmedStatus);
		$templateMgr->assign('declined', $reviewerSubmission->getDeclined());
		$templateMgr->assign('reviewFormResponseExists', $reviewFormResponseDao->reviewFormResponseExists($reviewId));
		$templateMgr->assign_by_ref('reviewFile', $reviewAssignment->getReviewFile());
		$templateMgr->assign_by_ref('reviewerFile', $reviewerSubmission->getReviewerFile());
		$templateMgr->assign_by_ref('suppFiles', $reviewerSubmission->getSuppFiles());
		$templateMgr->assign_by_ref('schedConf', $schedConf);
		$templateMgr->assign_by_ref('reviewGuidelines', $schedConf->getLocalizedSetting('reviewGuidelines'));

		// The reviewer instructions differ depending on what is reviewed, and when.
		if($reviewAssignment->getStage()==REVIEW_STAGE_ABSTRACT && $reviewerSubmission->getReviewMode() != REVIEW_MODE_BOTH_SIMULTANEOUS)
			$templateMgr->assign('reviewerInstruction3', 'reviewer.paper.downloadSubmissionAbstractOnly');
		else
			$templateMgr->assign('reviewerInstruction3', 'reviewer.paper.downloadSubmissionSubmission');

		import('submission.reviewAssignment.ReviewAssignment');
		$templateMgr->assign_by_ref('reviewerRecommendationOptions', ReviewAssignment::getReviewerRecommendationOptions());

		$controlledVocabDao =& DAORegistry::getDAO('ControlledVocabDAO');
                $sessionTypes = $controlledVocabDao->enumerateBySymbolic('paperType', ASSOC_TYPE_SCHED_CONF, $schedConf->getId());
		$templateMgr->assign('sessionTypes', $sessionTypes);

		$templateMgr->assign('helpTopicId', 'editorial.reviewersRole.review');		
                
                $trackDao =& DAORegistry::getDAO('TrackDAO');
                $templateMgr->assign_by_ref('tracks', $trackDao->getTrackTitles($schedConf->getId()));
                
                $authorComments = $reviewAssignment->getCommentAuthor();
                $comments = $reviewAssignment->getCommentDirector();
                $survey = $reviewAssignment->getCommentSurvey();
                
                $reviewFormId = $reviewAssignment->getReviewFormId();
                if (isset($reviewFormId)) {
                    $reviewFormDao =& DAORegistry::getDAO('ReviewFormDAO');
                    $reviewForm =& $reviewFormDao->getReviewForm($reviewFormId, ASSOC_TYPE_CONFERENCE, $conference->getId());
                    if (!isset($authorComments) || $authorComments === "") {
                        $authorComments = $reviewForm->getLocalizedDescription();
                    }
                    if (!isset($comments) || $comments === "") {
                        $comments = $reviewForm->getLocalizedTemplateForDirector();
                    }
                    //if (!isset($survey) || $survey === "") {
                        $surveyForm = $reviewForm->getLocalizedTemplateSurvey();
                    //}
                }
                
                $templateMgr->assign('commentAuthor', $authorComments);
                $templateMgr->assign('commentDirector', $comments);
                $templateMgr->assign('commentSurvey', $survey);
                $templateMgr->assign('commentSurveyForm', $surveyForm);
                
                $templateMgr->assign('draft', Request::getUserVar('draft'));
                
		$templateMgr->display('reviewer/submission.tpl');
	}

	function confirmReview($args = null) {
		$reviewId = Request::getUserVar('reviewId');
		$declineReview = Request::getUserVar('declineReview');

		$reviewerSubmissionDao =& DAORegistry::getDAO('ReviewerSubmissionDAO');

		$this->validate($reviewId);
		$reviewerSubmission =& $this->submission;
		$this->setupTemplate();
		
		$decline = isset($declineReview) ? 1 : 0;

		if (!$reviewerSubmission->getCancelled()) {
			if (ReviewerAction::confirmReview($reviewerSubmission, $decline, Request::getUserVar('send'))) {
				Request::redirect(null, null, null, 'submission', $reviewId, array(), 'reviewSteps');
			}
		} else {
			Request::redirect(null, null, null, 'submission', $reviewId, array(), 'reviewSteps');
		}
	}

	function recordRecommendation() {
		$reviewId = Request::getUserVar('reviewId');
		$recommendation = Request::getUserVar('recommendation');

		$this->validate($reviewId);
		$reviewerSubmission =& $this->submission;
		$this->setupTemplate(true);

		if (!$reviewerSubmission->getCancelled()) {
			if (ReviewerAction::recordRecommendation($reviewerSubmission, $recommendation, Request::getUserVar('send'))) {
				Request::redirect(null, null, null, 'submission', $reviewId, array(), 'reviewSteps');
			}
		} else {
			Request::redirect(null, null, null, 'submission', $reviewId, array(), 'reviewSteps');
		}
	}
        
        function recordRecommendationIntegrated() {
		$reviewId = Request::getUserVar('reviewId');
                $commentAuthor = Request::getUserVar('commentAuthor');
                $commentDirector = Request::getUserVar('commentDirector');
                $commentSurvey = Request::getUserVar('commentSurvey');
		$recommendation = Request::getUserVar('recommendation');
                $draft = Request::getUserVar('draft');

		$this->validate($reviewId);
		$reviewerSubmission =& $this->submission;
		$this->setupTemplate(true);

		if (!$reviewerSubmission->getCancelled()) {
                    if (ReviewerAction::recordRecommendationIntegrated($reviewerSubmission, $recommendation, $commentAuthor, $commentDirector, $commentSurvey, $recommendation, $draft, Request::getUserVar('send'))) {
                        Request::redirect(null, null, null, 'submission', $reviewId, array("draft"=>$draft), 'reviewSteps');
                        //Request::redirect(null, null, null, 'emailDirector', null, array('reviewId' => $reviewId));
                    }
		} else {
			Request::redirect(null, null, null, 'submission', $reviewId, array(), 'reviewSteps');
		}
	}

	function viewMetadata($args) {
		$reviewId = $args[0];
		$paperId = $args[1];

		$this->validate($reviewId);
		$reviewerSubmission =& $this->submission;

		$this->setupTemplate(true, $paperId, $reviewId);
		AppLocale::requireComponents(array(LOCALE_COMPONENT_OCS_AUTHOR)); // author.submit.agencies

		ReviewerAction::viewMetadata($reviewerSubmission, ROLE_ID_REVIEWER);
	}

	/**
	 * Upload the reviewer's annotated version of a paper.
	 */
	function uploadReviewerVersion() {
		$reviewId = Request::getUserVar('reviewId');

		$this->validate($reviewId);
		$this->setupTemplate(true);
		
		if (!ReviewerAction::uploadReviewerVersion($reviewId)) {
			$templateMgr =& TemplateManager::getManager();
			$templateMgr->assign('pageTitle', 'submission.uploadFile');
			$templateMgr->assign('message', 'common.uploadFailed');
			$templateMgr->assign('backLink', Request::url(null, null, null, 'submission', array($reviewId)));
			$templateMgr->assign('backLinkLabel', 'common.back');
			return $templateMgr->display('common/message.tpl');
		}
		Request::redirect(null, null, null, 'submission', $reviewId, array(), 'reviewSteps');
	}

	/*
	 * Delete one of the reviewer's annotated versions of a paper.
	 */
	function deleteReviewerVersion($args) {		
		$reviewId = isset($args[0]) ? (int) $args[0] : 0;
		$fileId = isset($args[1]) ? (int) $args[1] : 0;
		$revision = isset($args[2]) ? (int) $args[2] : null;

		$this->validate($reviewId);
		$reviewerSubmission =& $this->submission;

		if (!$reviewerSubmission->getCancelled()) ReviewerAction::deleteReviewerVersion($reviewId, $fileId, $revision);
		Request::redirect(null, null, null, 'submission', $reviewId, array(), 'reviewSteps');
	}

	//
	// Misc
	//

	/**
	 * Download a file.
	 * @param $args array ($paperId, $fileId, [$revision])
	 */
	function downloadFile($args) {
		$reviewId = isset($args[0]) ? $args[0] : 0;
		$paperId = isset($args[1]) ? $args[1] : 0;
		$fileId = isset($args[2]) ? $args[2] : 0;
		$revision = isset($args[3]) ? $args[3] : null;

		$this->validate($reviewId);
		$reviewerSubmission =& $this->submission;
		if (!ReviewerAction::downloadReviewerFile($reviewId, $reviewerSubmission, $fileId, $revision)) {
			Request::redirect(null, null, null, 'submission', $reviewId, array(), 'reviewSteps');
		}
	}
	
	//
	// Review Form
	//

	/**
	 * Edit or preview review form response.
	 * @param $args array
	 */
	function editReviewFormResponse($args) {
		$reviewId = isset($args[0]) ? $args[0] : 0;
		
		$this->validate($reviewId);

		$reviewAssignmentDao =& DAORegistry::getDAO('ReviewAssignmentDAO');
		$reviewAssignment =& $reviewAssignmentDao->getReviewAssignmentById($reviewId);
		$reviewFormId = $reviewAssignment->getReviewFormId();
		if ($reviewFormId != null) {
			ReviewerAction::editReviewFormResponse($reviewId, $reviewFormId);		
		}
	}

	/**
	 * Save review form response
	 * @param $args array
	 */
	function saveReviewFormResponse($args) {
		$reviewId = isset($args[0]) ? $args[0] : 0;
		$reviewFormId = isset($args[1]) ? $args[1] : 0;

		$this->validate($reviewId);
		$this->setupTemplate(true);

		if (ReviewerAction::saveReviewFormResponse($reviewId, $reviewFormId)) {
                    Request::redirect(null, null, null, 'submission', $reviewId, array(), 'reviewSteps');
		}
	}

	//
	// Validation
	//

	/**
	 * Validate that the user is an assigned reviewer for
	 * the paper.
	 * Redirects to reviewer index page if validation fails.
	 */
	function validate($reviewId) {
		$reviewerSubmissionDao =& DAORegistry::getDAO('ReviewerSubmissionDAO');
		$schedConf =& Request::getSchedConf();
		$user =& Request::getUser();

		$isValid = true;
		$newKey = Request::getUserVar('key');

		$reviewerSubmission =& $reviewerSubmissionDao->getReviewerSubmission($reviewId);

		if (!$reviewerSubmission || $reviewerSubmission->getSchedConfId() != $schedConf->getId()) {
			$isValid = false;
		} elseif ($user && empty($newKey)) {
			if ($reviewerSubmission->getReviewerId() != $user->getId()) {
				$isValid = false;
			}
		} else {
			$user =& SubmissionReviewHandler::validateAccessKey($reviewerSubmission->getReviewerId(), $reviewId, $newKey);
			if (!$user) $isValid = false;
		}

		if (!$isValid) {
			Request::redirect(null, null, Request::getRequestedPage());
		}

		$this->submission =& $reviewerSubmission;
		$this->user =& $user;
		return true;
	}
        
        function emailDirector($args = array()) {
		$paperId = (int) Request::getUserVar('paperId');
                $paperDao =& DAORegistry::getDAO('PaperDAO');
		$paper =& $paperDao->getPaper($paperId);
                
		$conference =& Request::getConference();
		$schedConf =& Request::getSchedConf();
		$submission =& $this->submission;

		$this->setupTemplate(true, $paperId, 'review');
                
		if (ReviewerAction::emailDirector($paper, $paperId)) {
			Request::redirect(null, null, null, 'submission', $paperId, 'peerReview');
		}
	}
}
?>
