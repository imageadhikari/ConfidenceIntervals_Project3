# Confidence Intervals Project 3
This project was done to fulfill the project 3 requirements for the course CISC 820 - Quantitative Foundations.

In this project, we experiment with different confidence intervals. We test the 10 given functions which return different confidence intervals to determine which ones are valid and which ones are not. For the ones that are valid, we determine the level of confidence and also define if they are the exact confidence intervals or only asymptotically.

## Reproducing the Project

To reproduce this project, follow these steps:

### Clone the repository:
   ```bash
   git clone https://github.com/imageadhikari/ConfidenceIntervals_Project3.git
   ```

### Make sure this is the working directory in matlab.
 
### Running the script:
1. For all distributions:
    ```bash
    project_3(1:10, 'all'); 
    ```
2. For a specific distribution:
- Bernoulli:
    ```bash
    project_3(1:10, 'bernoulli'); 
    ```

- Uniform:
    ```bash
    project_3(1:10, 'uniform'); 
    ```

- Noisy:
    ```bash
    project_3(1:10, 'noisy'); 
    ```

3. For a subset of functions:
- Bernoulli:
    ```bash
    project_3([1,3,5], 'bernoulli'); 
    ```

- Uniform:
    ```bash
    project_3([1,3,5], 'uniform'); 
    ```

- Noisy:
    ```bash
    project_3([1,3,5], 'noisy'); 
    ```

4. Without any parameters:
    ```bash
    project_3; 
    ```


### Ensure the Noisy Dataset is Pre-generated
Before running the script with 'noisy':
```bash
generate_noisy_dataset; 
```

## Results:
The results for the different distributions can be found in the [Results](./Results/) folder. 

## Authors
1. Image Adhikari
2. Patrick Philippy


