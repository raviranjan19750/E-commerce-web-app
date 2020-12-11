part of 'bulk_order_bloc.dart';

abstract class BulkOrderState{}

class InitialState extends BulkOrderState {}

class StepOneDone extends BulkOrderState{}

class StepTwoDone extends BulkOrderState{}

class StepThreeDone extends BulkOrderState{}