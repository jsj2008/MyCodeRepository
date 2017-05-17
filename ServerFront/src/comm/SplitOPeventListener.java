package comm;

public interface SplitOPeventListener {

	public void opResult(boolean succeed, String errCode, String errMessage);

	public void splitEvent(int totalStep, int currentStep);

	public void splitResult(int index, boolean succeed, String errCode, String errMessage);
}
