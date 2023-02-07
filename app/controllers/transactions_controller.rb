class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: TransactionDatatable.new(params, view_context: view_context) }
    end
  end

  def show; end

  def new
    @transaction = Transaction.new
  end

  def edit
    authorize @transaction
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      redirect_to transaction_url(@transaction), notice: 'Transaction was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @transaction

    if @transaction.update(transaction_params)
      redirect_to transaction_url(@transaction), notice: 'Transaction was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @transaction

    @transaction.destroy
    redirect_to transactions_url, notice: 'Transaction was successfully destroyed.'
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit :loan_date, :return_date, :period, :user_id, :book_id
  end
end
