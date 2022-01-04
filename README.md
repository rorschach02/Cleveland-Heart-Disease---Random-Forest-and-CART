# Fitting Decision Tree and Random Forest on Cleveland Heart Disease Dataset.

## Dataset Factors: 
<pre>
The dataset consists of 303 individuals data. There are 14 columns in the dataset, which are described below. <br/>
1 . Age: displays the age of the individual.  <br/>
2.  Sex: displays the gender of the individual using the following format :  <br/>
     1 = male  <br/>
     0 = female  <br/>
3. Chest-pain type: displays the type of chest-pain experienced by the individual using the following format :  <br/>
   1 = typical angina  <br/>
   2 = atypical angina  <br/>
   3 = non — anginal pain  <br/>
   4 = asymptotic  <br/>
4. Resting Blood Pressure: displays the resting blood pressure value of an individual in mmHg (unit) <br/>
5. Serum Cholestrol: displays the serum cholesterol in mg/dl (unit)  <br/>
6. Fasting Blood Sugar: compares the fasting blood sugar value of an individual with 120mg/dl.  <br/>
   If fasting blood sugar > 120mg/dl then : 1 (true)  <br/>
   else : 0 (false)  <br/>
7. Resting ECG : displays resting electrocardiographic results  <br/>
   0 = normal  <br/>
   1 = having ST-T wave abnormality  <br/>
   2 = left ventricular hyperthrophy  <br/>
8. Max heart rate achieved : displays the max heart rate achieved by an individual.  <br/>
9. Exercise induced angina :  <br/>
   1 = yes  <br/>
   0 = no  <br/>
10. ST depression induced by exercise relative to rest: displays the value which is an integer or float.  <br/>
    Peak exercise ST segment :  <br/>
    1 = upsloping  <br/>
    2 = flat  <br/>
    3 = downsloping  <br/>
11. Number of major vessels (0–3) colored by flourosopy : displays the value as integer or float.  <br/>
    Thal : displays the thalassemia :  <br/>
    3 = normal  <br/>
    6 = fixed defect  <br/>
    7 = reversible defect  <br/>
14. Diagnosis of heart disease : Displays whether the individual is suffering from heart disease or not :  <br/>
    0 = absence  <br/>
    1, 2, 3, 4 = present.  <br/>
</pre>


## Libraries: 
-- ISLR <br/>
-- corrplot <br/>
-- MASS <br/>
-- klaR <br/>
-- leaps <br/>
-- lattice <br/>
-- ggplot2 <br/>
-- corrplot <br/>
-- car <br/>
-- caret <br/>
-- class <br/>
-- plotly <br/>
-- neuralnet <br/>
-- fastDummies <br/>

## CART:
Classification for decision Trees A decision tree is a flowchart-like structure in which each internal node represents a “test” on an attribute, each branch represents the
outcome of the test, and each leaf node represents a class label. The paths from root to leaf represent classification rules.

![decision_tree](https://user-images.githubusercontent.com/46763031/148013234-2e10749e-a031-4380-b7ff-7c41e4918cbf.png)

![cp for model selection](https://user-images.githubusercontent.com/46763031/148013273-c410cfb9-b486-482e-8862-9e3a0d5bbe7a.png)

![pruned decision tree](https://user-images.githubusercontent.com/46763031/148013288-64a77526-91c9-4b8e-b61a-d0eb62507608.png)

#### Result: 
The test error using prune desision tree is 25.42%.

## Random Forest:
Random decision forests are an ensemble learning method for classification, regression and other tasks that operates by constructing a multitude of
decision trees at training time.

![random forest main features](https://user-images.githubusercontent.com/46763031/148013436-a78eeb08-937b-49d2-946e-924edb9eec6d.png)

#### Result:
The test error using random forest is 11.86%.


